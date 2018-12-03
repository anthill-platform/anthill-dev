
from subprocess import Popen, PIPE
import sys
import yaml
import json
import os
from queue import Queue, Empty
from threading import Thread
import time


def _find_getch():
    try:
        import termios
    except ImportError:
        # Non-POSIX. Return msvcrt's (Windows') getch.
        import msvcrt
        return msvcrt.getch

    # POSIX system. Create and return a getch that manipulates the tty.
    import sys, tty
    def _getch():
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setraw(fd)
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch

    return _getch


getch = _find_getch()


class Status(object):
    def __init__(self):
        self.done = False


def enqueue_output(out, queue):
    for line in iter(out.readline, b''):
        queue.put(line)
    out.close()


def exit_f(status):
    print("Simple Service Runner: Hit any key ot stop.")
    getch()
    status.done = True


def run(service_settings):
    services = service_settings["services"]

    status = Status()
    q = Queue()
    processes = {}

    t = Thread(target=exit_f, args=(status,))
    t.daemon = True
    t.start()

    time.sleep(1)

    for service in services:
        service_name = service["name"]
        service_package = service["package"]
        service_args = [
            sys.executable, "-m", str(service_package)
        ]
        service_args.extend(service.get("args", []))
        service_path = os.path.abspath(os.path.join("../", service_name))
        print("Starting a service at: " + service_path)
        env = os.environ.copy()
        env["PYTHONPATH"] = os.path.abspath("../common")
        p = Popen(service_args, cwd=service_path, stdout=PIPE, stderr=PIPE, env=env)

        processes[service_name] = p

        t_out = Thread(target=enqueue_output, args=(p.stdout, q))
        t_out.daemon = True

        t_err = Thread(target=enqueue_output, args=(p.stderr, q))
        t_err.daemon = True

        t_out.start()
        t_err.start()

    while True:
        if status.done:
            for name, p in processes.items():
                print("Killing {0}...".format(name))
                try:
                    p.kill()
                except Exception as e:
                    print(e)
            print("Goodbye")
            break

        try:
            line = q.get_nowait()
        except Empty:
            pass
        else:
            sys.stdout.write(line.decode())


if __name__ == "__main__":
    with open("runner-services.yaml", "r") as f:
        settings = yaml.load(f)

    run(settings)


# Hack In

This branch is made for the purpose of development of the anthill itself.

### Mac OS X

To setup minimal development environment on Mac Os X, you will need:

1. Install [PyCharm](https://www.jetbrains.com/pycharm/download) (Community Edition is fine)
2. Clone this branch, including all submodules
    ```bash
    git clone -b dev https://github.com/anthill-platform/anthill-dev.git
    cd anthill-dev
    git submodule update --init --recursive
    ```
3. Install docker. Run:
    ```bash
    docker-compose up .
    ```
4. Open [http://localhost:9500](http://localhost:9500) in your browser
5. Press "Proceed", login using username `root` and password `anthill`. You should see something like this:

<div align="center">
<a href="https://user-images.githubusercontent.com/1666014/32834423-3b24fef6-ca0b-11e7-8276-240d3ccb6ce8.png"><img src="https://user-images.githubusercontent.com/1666014/32834374-0ba5b288-ca0b-11e7-8f2a-0d6729f76a60.png" width="250"></a>
</div>

#! /bin/zsh
xcode_install() {
    xcode-select -p || xcode-select --install
}

brew_install() {
    # FYI to uninstall https://github.com/Homebrew/install
    which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_tools() {
    brew update

    # install apps via brew
    tools=(\
        cmake \
        coreutils \
        ctags \
        diffutils \
        findutils \
        gawk \
        git \
        gnu-sed \
        gnu-tar \
        grep \
        gzip \
        hub \
        htop
        jq \
        pyenv \
        pyenv-virtualenv \
        the_silver_searcher \
        unzip \
        vim \
        watch \
        wget \
        zlib)

    for t in ${tools[@]}; do
        brew install $(echo $t)
    done;
}

install_apps() {
    apps=(\
        1password \
        alfred \
        docker \
        firefox \
        font-source-code-pro \
        github-desktop \
        google-chrome \
        iterm2 \
        java \
        spectacle \
        spotify \
        sublime-text \
        qlstephen \
        vivaldi)
    # install apps
    for a in ${apps[@]}; do
        brew cask install $a
    done;
}

finder() {
    defaults write com.apple.finder AppleShowAllFiles YES
}

generate_rsa_key() {
    echo "What email should be used for rsa key?"
    read email
    rsa_path="$HOME/.ssh/${email}_rsa"
    ssh-keygen -t rsa -b 4096 -C $email -f $rsa_path
    eval "$(ssh-agent -s)"
    ssh-add -K $rsa_path
}

install_python() {
    pyenv install 2.7.15
    pyenv install 3.6.7
}

init() {
    xcode_install

    generate_rsa_key

    brew_install

    install_tools

    install_apps
}

# Jekyll

[Site officiel](https://jekyllrb.com/)

## Quick start

1. Installer Ruby :
    ```bash
    sudo apt-get install ruby-full build-essential zlib1g-dev
    echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    ```
1. Installer Jekyll :
    ```bash
    gem install jekyll bundler
    ```
1. Créer un site web :
    ```bash
    jekyll new nomSite
    cd nomSite
    bundle exec jekyll serve
    # => Now browse to http://localhost:4000
    ```
sudo apt-get install make g++ curl valgrind pandoc texlive-latex-recommended

mkdir -p ~/.env
cd .env
git clone git://github.com/mozilla/rust.git
cd rust
git checkout release-0.7
./configure
make
make install

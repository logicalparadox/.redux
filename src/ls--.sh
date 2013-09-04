cd /tmp
git clone https://github.com/trapd00r/ls--.git
cd ls--
perl Makefile.PL
make && su -c 'make install'
cd /tmp
rm -rf ls--

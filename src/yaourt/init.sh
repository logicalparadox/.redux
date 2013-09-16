mkdir -p /tmp/yaourt
cd /tmp/yaourt
curl -O https://aur.archlinux.org/packages/ya/yaourt/PKGBUILD
makepkg -si --noconfirm
rm -rf /tmp/yaourt

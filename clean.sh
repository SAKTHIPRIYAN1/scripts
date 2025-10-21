#!/bin/bash
echo "🔹 Starting safe system cleanup..."

# 1. APT cleanup (Safe)
echo "→ Cleaning APT cache..."
sudo apt clean -y
sudo apt autoclean -y
sudo apt autoremove --purge -y

# 2. Remove old kernel images (Safe)
# Keeps the currently running kernel
echo "→ Removing old kernels..."
sudo apt-get remove --purge $(dpkg -l 'linux-image*' | awk '/^ii/{print $2}' | grep -v $(uname -r)) -y 2>/dev/null || true
sudo update-grub >/dev/null 2>&1

# 3. Clear journal logs (Safe method)
echo "→ Cleaning old system logs..."
sudo journalctl --vacuum-time=3d

# 4. Clear apt, snap, and flatpak leftovers (Safe)
echo "→ Removing old snap & flatpak versions..."
if command -v snap &>/dev/null; then
  sudo snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do
    sudo snap remove "$snapname" --revision="$revision"
  done
fi
if command -v flatpak &>/dev/null; then
  flatpak uninstall --unused -y
fi

# 5. Clear user trash (Safe)
echo "→ Clearing user trash..."
rm -rf ~/.local/share/Trash/*

# 6. Clean developer caches (Safe)
# It's better to run these manually, but they aren't dangerous
echo "→ Cleaning developer caches (npm, pip)..."
if command -v npm &>/dev/null; then npm cache clean --force >/dev/null 2>&1; fi
if command -v pip &>/dev/null; then pip cache purge -y >/dev/null 2>&1; fi

# 7. Clean old, compressed logs (Safer than before)
# This removes old, rotated logs, but leaves active ones alone.
echo "→ Cleaning compressed logs..."
sudo rm -f /var/log/*.gz /var/log/*.[0-9]

# 8. Summarize disk usage
echo " Cleanup done!"
echo " Disk usage after cleanup:"
df -h /

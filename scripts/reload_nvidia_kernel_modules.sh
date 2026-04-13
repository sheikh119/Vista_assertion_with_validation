#!/usr/bin/env bash
# Diagnose NVIDIA "Driver/library version mismatch" on Pop!_OS / Ubuntu.
# This is NOT fixable from Python; the kernel must load the same module version
# as your installed libnvidia packages.

set -euo pipefail

loaded=""
disk=""
if [[ -r /sys/module/nvidia/version ]]; then
  loaded="$(tr -d '\n' < /sys/module/nvidia/version)"
fi
if command -v modinfo >/dev/null 2>&1; then
  disk="$(modinfo -F version nvidia 2>/dev/null | tr -d '\n' || true)"
fi

echo "NVIDIA kernel module in RAM:  ${loaded:-<not loaded>}"
echo "NVIDIA module on disk (modinfo): ${disk:-<unknown>}"
echo

if [[ -n "$loaded" && -n "$disk" && "$loaded" != "$disk" ]]; then
  echo "Mismatch: the running kernel still has the OLD driver in memory."
  echo "Your .ko files on disk are already updated — you only need the kernel to load them."
  echo
  echo "Try, in order:"
  echo "  1) Full reboot:  sudo reboot"
  echo "  2) If you use Fast Startup / hybrid sleep, do a full shutdown instead:"
  echo "       sudo systemctl poweroff"
  echo "     then turn the machine back on after ~10 seconds."
  echo "  3) If it STILL mismatches after a cold boot, reinstall DKMS and reboot:"
  echo "       sudo apt update"
  echo "       sudo apt install --reinstall nvidia-dkms-580-open nvidia-driver-580-open"
  echo "       sudo reboot"
  echo
  echo "Advanced (no reboot): from a text console (Ctrl+Alt+F3) after stopping the GUI,"
  echo "unload then reload the stack (may black out the screen briefly):"
  echo "  sudo systemctl isolate multi-user.target"
  echo "  sudo modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia"
  echo "  sudo modprobe nvidia"
  echo "  sudo systemctl isolate graphical.target"
  exit 1
fi

if [[ -z "$loaded" ]]; then
  echo "NVIDIA module not loaded. Boot with NVIDIA enabled or install nvidia-driver-*."
  exit 1
fi

echo "Loaded and on-disk versions match. If nvidia-smi still fails, check dkms and kernel packages."
exit 0

#!/bin/sh

# Run the PipeWire startup sequence asynchronously in a detached subshell.
# This prevents Sway's 'exec' from blocking startup and ensures Waybar and other components launch instantly.
(
  XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

  # If PipeWire socket does not exist, any running pipewire/wireplumber processes are stale orphans from a previous session.
  # Clean them up so fresh daemons can bind to the new session sockets.
  if [ ! -S "$XDG_RUNTIME_DIR/pipewire-0" ]; then
    pkill -u "$USER" -9 -x "pipewire|pipewire-pulse|wireplumber" >/dev/null 2>&1
    sleep 0.2
  fi

  # Ensure D-Bus session bus is available
  if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    if command -v dbus-launch >/dev/null 2>&1; then
      eval "$(dbus-launch --sh-syntax)"
      export DBUS_SESSION_BUS_ADDRESS
    fi
  fi

  # Update D-Bus activation environment if available
  if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS >/dev/null 2>&1
  fi

  # Helper function to start a process only if it is not already running
  start_if_not_running() {
    proc_name="$1"
    shift
    if ! pgrep -u "$USER" -x "$proc_name" >/dev/null 2>&1; then
      "$proc_name" "$@" >/dev/null 2>&1 &
    fi
  }

  # 1. Start PipeWire core daemon
  start_if_not_running pipewire

  # 2. Wait for PipeWire socket to be created (up to 3 seconds)
  count=0
  while [ ! -S "$XDG_RUNTIME_DIR/pipewire-0" ] && [ $count -lt 30 ]; do
    sleep 0.1
    count=$((count + 1))
  done

  # 3. Start PipeWire PulseAudio compatibility layer
  start_if_not_running pipewire-pulse

  # 4. Start WirePlumber session manager after PipeWire socket is ready
  start_if_not_running wireplumber
) >/dev/null 2>&1 &




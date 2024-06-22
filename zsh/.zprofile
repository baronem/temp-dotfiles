if [ "$(tty)" = "/dev/tty1" ]; then
	exec /home/mb/.local/bin/start-sway
fi

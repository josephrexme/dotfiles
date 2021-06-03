if [ "$TERM_PROGRAM" = tmux ]; then
  echo "exiting ck tmux session"
  # Stop rails servers (ck and fk) and put down docker
  cat $CK_PATH/tmp/pids/server.pid | xargs -n1 -I pid kill -9 pid
  cat $FIELKIT_PATH/tmp/pids/server.pid | xargs -n1 -I pid kill -9 pid
  docker-compose --file $CK_PATH/dev/docker-compose-dependencies.yml down
  tmux kill-session
else
  tmux new-session \; \
    send-keys 'j functions && npm start' C-m \; \
    split-window -v -p 50 \; \
    send-keys 'j convertkit && ckdev' C-m \; \
    split-window -v -p 50 \; \
    send-keys '(sleep 30 && j filekit && rails s)' C-m \; \
    split-window -h -p 50 \; \
    send-keys 'docker-compose --file $CK_PATH/dev/docker-compose-dependencies.yml up' C-m \; \
    select-pane -t 0 \; \
    split-window -v -p 50 \; \
    send-keys '(sleep 30 && j convertkit && rails s)' C-m \;
fi

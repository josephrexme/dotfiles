if [ "$TERM_PROGRAM" = tmux ]; then
  echo "Exiting ck tmux session"
  # Stop rails servers (ck and fk) and put down docker
  cat $KIT_APP_PATH/tmp/pids/server.pid | xargs -n1 -I pid kill -9 pid
  cat $FILEKIT_PATH/tmp/pids/server.pid | xargs -n1 -I pid kill -9 pid
  # Stop functions JS server
  kill $(lsof -wni tcp:3031 | awk 'NR == 2 {print $2}')
  # Put down docker
  docker compose --file $KIT_APP_PATH/dev/docker-compose-dependencies-m1.yml down
  tmux kill-session
else
  tmux new-session \; \
    send-keys 'cd $KIT_APP_PATH/packages/functions && npm start' C-m \; \
    split-window -v -p 50 \; \
    send-keys 'cd $KIT_APP_PATH && kitdev' C-m \; \
    split-window -v -p 50 \; \
    send-keys '(sleep 30 && cd $FILEKIT_PATH && rails s)' C-m \; \
    split-window -h -p 50 \; \
    send-keys 'docker compose --file $KIT_APP_PATH/dev/docker-compose-dependencies-m1.yml up' C-m \; \
    select-pane -t 0 \; \
    split-window -v -p 50 \; \
    send-keys '(sleep 30 && cd $KIT_APP_PATH && be rails s)' C-m \;
fi

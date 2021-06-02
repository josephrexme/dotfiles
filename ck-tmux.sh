tmux new-session \; \
  send-keys 'j functions && npm start' C-m \; \
  split-window -v -p 50 \; \
  send-keys 'j convertkit && ckdev' C-m \; \
  split-window -v -p 50 \; \
  send-keys 'j filekit && rails s' C-m \; \
  split-window -h -p 50 \; \
  send-keys 'j convertkit && ./bin/docker-dependencies' C-m \; \
  select-pane -t 0 \; \
  split-window -v -p 50 \; \
  send-keys '(sleep 30 && j convertkit && rails s)' C-m \; \

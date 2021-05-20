tmux new-session \; \
  send-keys 'nvm use 14 && j functions && npm start' C-m \; \
  split-window -v -p 50 \; \
  send-keys 'nvm use 14 && j convertkit && ckdev' C-m \; \
  split-window -v -p 50 \; \
  send-keys 'j filekit && rails s' C-m \; \
  split-window -h -p 50 \; \
  send-keys 'j convertkit && ./bin/docker-dependencies' C-m \; \
  select-pane -t 0 \; \
  split-window -v -p 50 \; \
  send-keys '(sleep 40 && j convertkit && rails s)' C-m \; \

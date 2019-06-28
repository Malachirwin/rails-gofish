import Pusher from 'pusher-js'
if (!window.pusher) {
  window.pusher = new Pusher("39f3a6aa23acc09d4631", {
    cluster: "us2"
  });
}
const channel = window.pusher.subscribe('app');
channel.bind('new-games', (data) => {
  if (window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
});
channel.bind('another-joined', (data) => {
  if (window.location.pathname === `/games/${data.game_id}` || window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
});
channel.bind('someone-left', (data) => {
  if (window.location.pathname === `/games/${data.game_id}` || window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
});
channel.bind('game-is-starting', (data) => {
  if (window.location.pathname === `/games/${data.game_id}` || window.location.pathname === '/games') {
    if (data.user_id !== document.body.dataset.current_user_id) {
      window.location.reload()
    }
  }
});

debugger
const pusher = new Pusher("39f3a6aa23acc09d4631", {
  cluster: "us2"
});
const channel = pusher.subscribe('app');
channel.bind('new-games', (data) => {
  if (window.location.pathname === '/games') {
    window.location.reload()
  }
});
channel.bind('another-joined', (data) => {
  if (window.location.pathname.includes('/games/') && window.location.pathname !== '/games/new') {
    window.location.reload()
  }
});

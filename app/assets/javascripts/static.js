// NAVIGATION
function toggleSidenav() {
  var sidenav = document.getElementById('sidenav');
  var icon = document.getElementById('sidenav-icon');
  sidenav.classList.toggle('active');
  icon.classList.toggle('active');
}

// NOTIFICATION
function closeNotification() {
  var trgt = document.getElementById('notification');
  trgt.removeChild(trgt.children[0])
}

function createNotification(status, text) {
  // Create Container
  var notification = document.createElement('div');
  notification.id = status;
  // Add Notification Text
  var info = document.createElement('p');
  info.innerHTML = text;
  // Add Close Button
  var close = document.createElement('i');
  close.classList.add('fa','fa-times');
  // Add Info and Button to Container
  notification.append(info);
  notification.append(close);
  // Add Container to Notification
  document.getElementById('notificiation').append(notification);
  // Close Container on Click
  close.addEventListener('click', function() {
    closeNotification();
  })
}

// INDEX
function particles() {
  particlesJS.load('particles', '/particles-js.json', function() { });
}

// DIRECTORY
function toggleLanguages(x) {
  var languages = document.getElementById('languages');
  languages.classList.toggle('active');
  x.classList.toggle('active');
}

function toggleCategories(x) {
  var categories = document.getElementById('categories');
  categories.classList.toggle('active');
  x.classList.toggle('active');
}

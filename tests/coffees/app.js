
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , todo = require('./routes/todo')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

var todotxt = (process.argv.length > 2 ? process.argv[2] : "todo.todo");
var donetxt = (process.argv.length > 3 ? process.argv[3] : "done.todo");
console.log("Path to todo.todo: " + todotxt);
console.log("Path to todo.todo: " + donetxt);

app.get('/', routes.index);
app.get('/users', user.list);

var todor = todo.r(todotxt, donetxt);
app.get('/todo', todor.read);
app.get('/todo/list', todor.todolist);
app.get('/todo/do', todor.done);
app.get('/todo/new', todor.newtodo);
app.get('/todo/refresh', todor.refresh);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});

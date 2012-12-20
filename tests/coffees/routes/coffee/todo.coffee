fs = require('fs')
path = require('path');
child_process = require('child_process')

loadFile = (todotxt) ->

  lines = do ->  
      resp = fs.readFileSync(todotxt, 'utf-8')
      resp.split(/\r?\n/)
writeFile = (filen, data) ->
   fs.writeFileSync(filen, data.join("\n"), 'utf-8') 
   true

loadTodos = (todotxt) ->
    lines = loadFile(todotxt)

    catchAndStrip = (reg, txt) ->
      rr = txt.match(reg)
      if rr
          txt = txt.replace(reg, "")
          [rr[1], txt]
      else
          [null, txt]
      
    prio = /\(([a-z])\)/
    duedate = /\^([a-zA-Z0-9-.,_]+)/
    lists = lines.filter((l) -> !!l ).map (l) ->
      [pr, l] = catchAndStrip(prio, l)
      [due, l] = catchAndStrip(duedate, l)
      [l, pr, due]

    lists


class MyTodo
  constructor: (@todotxt, @donetxt) ->

  todolist: (req, res) =>
    lists = loadTodos(@todotxt)
    res.render('todolist', {mlines: lists})

  read:  (req, res) =>
    lists = loadTodos(@todotxt)
    res.render('todo', {mlines: lists})

  refresh:  (req, res) =>
    paths = path.resolve(@todotxt);
    paths = paths.substring(0, paths.lastIndexOf("/"))
    child_process.exec("git pull lin master", { cmd: paths}, (err, stdout, stderr) ->
        if err
            console.log("Error! #{err}")
        else
            console.log("GIT: Updated! #{stdout}")
        res.redirect('/todo')
    )

    
  newtodo:  (req, res) =>
    descn = req.query.desc
    prio = req.query.prio
    if descn
        lines = loadFile(@todotxt)
        newLine = (if prio then "(#{prio}) " else "") + "#{descn}"
        lines.push(newLine)
        writeFile(@todotxt, lines)

    res.redirect('/todo')


  done: (req, res) =>
    lines = loadFile(@todotxt)
    lid = req.query.id
    doneItem = null
    if lines.length >= lid-1
        # delete line from it.
        doneItem = lines.splice(lid, 1)
    writeFile(@todotxt, lines)

    console.log("done: " + doneItem)
    if doneItem.length == 1
        donelines = loadFile(@donetxt)
        console.log("done: " + doneItem[0])
        donelines.push doneItem[0]
        writeFile(@donetxt, donelines)

    res.redirect('/todo/list')

    
exports.r = (todotxt, donetxt) -> 
    read: new MyTodo(todotxt, donetxt).read
    done: new MyTodo(todotxt, donetxt).done
    todolist: new MyTodo(todotxt, donetxt).todolist
    newtodo: new MyTodo(todotxt, donetxt).newtodo
    refresh: new MyTodo(todotxt, donetxt).refresh

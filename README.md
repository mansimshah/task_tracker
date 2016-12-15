# task_tracker

Install bundle using command,
bundle install

1) To create new Task as a Manager,

URL  ->  http://localhost:4567/tasks
Request Parameter ->
{
  "user_id" : "58514b3d6ea31ce56f3a3483",
  "token": "k78FNomy4p3194tIf05j431rIhGHfF1D",
  "name":"Task1",
  "description":"testing task", 
  "status":"new",
  "pickup_lat": -22.23, 
  "pickup_lng": 40.22, 
  "delivery_lat": -47.21, 
  "delivery_lng": -80.48
}

2) To update task as a Driver,

URL -> http://localhost:4567/tasks/58514d047a0390d892265830
Request Parameter ->
{
{
	"user_id" : "58514bfc6ea31ce56f3a3486",
	"token"   : "2J4v9vV3Af3y1NG4I31k5jbXyxg0KX3c",
  "status"  : "done"
}

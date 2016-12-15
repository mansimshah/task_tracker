require 'sinatra'
require 'mongoid'
require 'geocoder'
require './models/user.rb'
require './models/task.rb'
require './helpers/base_helper.rb'

# DB Setup
Mongoid.load! "mongoid.config"

# Manager create task

post '/tasks' do
  
  params = JSON.parse(request.body.read).symbolize_keys
  message = {}

  if params[:token].present?
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      if @user.present? && @user[:token] == params[:token] && @user[:role] == "Manager"

        task_params = {
          "name": params[:name],
          "description": params[:description],
          "status": params[:status],
          "pickup_lat": params[:pickup_lat],
          "pickup_lng": params[:pickup_lng],
          "delivery_lat": params[:delivery_lat],
          "delivery_lng": params[:delivery_lng]
        }

        task = Task.new(task_params)
        if task.save
          status 201
          message = "Task is created successfully."
        else
          status 422
          message = "Task is not created."
        end
      else
        message = "Invalid User." 
      end
    end
  else
    message[:notice] = "Token is required"   
  end  
  message.to_json
end


# Driver can get list of tasks nearby (sorted by distance) by sending his current location

# TODO 
# post '/task_list' do
#   params = JSON.parse(request.body.read).symbolize_keys
  
#   if params[:token].present?
#     if params[:user_id].present?
#       @user = User.find(params[:user_id])
      
#       if  @user.present? && @user[:token] == params[:token] && @user[:role] == "Driver"
#         @tasks = Task.near([params[:current_lat], params[:current_lng]],20)
#       end
#     end  
#   else
#     puts "Token is required"  
#   end
# end

# Driver can change status of task (to assigned/done).

patch '/tasks/:id' do |id|

  message = {}

  if params[:token].present?
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      if @user.present? && @user[:token] == params[:token] && @user[:role] == "Driver"
        task = Task.where(id: id).first
        if task.update(status: params[:status])
          status 200
          message[:notice] = "Task updated"
        else
          status 422
          message[:notice] = "Task is not updated"
        end
      else
          message[:notice] = "Invalid params"
      end
    else
        message[:notice] = "Invalid User"
    end
  else
    message[:notice] = "Token is required"    
  end
  message.to_json
end

# File: users_controller.rb
# Purpose: Implementation of Users Controller
# License: LGPL. No copyright.

# This controller contains the logic involving creating and setting attributes
# for the correspondent view of a single user

class UsersController < ApplicationController

  # name: new
  # explanation: this method instantiates a new user to be used in the view
  # parameters:
  # - none
  # return: object of type User
  def new
    @user = User.new

    assert(!@user.nil?)
    assert(@user.kind_of?(User))

    return @user
  end

end

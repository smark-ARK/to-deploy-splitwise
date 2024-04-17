class StaticController < ApplicationController
  include FriendsConcern

  
  def dashboard
    @friends = fetch_friends
  end

  def person
  end
end

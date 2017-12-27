class NodesController < ApplicationController

  def block
      current_user.block_node(params[:id])
  end

  def unblock
    current_user.unblock_node(params[:id])
  end

end

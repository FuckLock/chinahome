class NodesController < ApplicationController

  def block
    @node = Node.find_by(id: params[:id])
    current_user.block_node(@node)
  end

  def unblock
    @node = Node.find_by(id: params[:id])
    current_user.unblock_node(@node)
  end

end

class Admin::NodesController < Admin::ApplicationController
  def index
    @nodes = Node.all
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(params[:node].permit!)
    if @node.save
      redirect_to admin_nodes_path, notice: "Node was successfully created"
    else
      render action: "new"
    end
  end

  def edit
    @node = Node.find_by(id: params[:id])
  end

  def update
    @node = Node.find_by(id: params[:id])
    if @node.update(params[:node].permit!)
      redirect_to admin_nodes_path, notice: "Node was successfully updated"
    else
      render action: :edit
    end
  end

  def destroy
    @node = Node.find_by(id: params[:id])
    @node.destroy
    redirect_to admin_nodes_path
  end
end

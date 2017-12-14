class Admin::SectionsController < Admin::ApplicationController
  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section].permit!)
    if @section.save
      redirect_to admin_sections_path, notice: "Section was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @section = Section.find_by(id: params[:id])
  end

  def update
    @section = Section.find_by(id: params[:id])
    if @section.update(params[:section].permit!)
      redirect_to(admin_sections_path, notice: "Section was successfully updated.")
    else
      render action: "edit"
    end
  end

  def destroy
    @section = Section.find_by(id: params[:id])
    @section.destroy
    redirect_to admin_sections_path
  end
end

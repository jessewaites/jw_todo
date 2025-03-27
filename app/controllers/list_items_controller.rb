class ListItemsController < ApplicationController
  before_action :set_list
  before_action :set_list_item, only: %i[ show edit update destroy ]

  # GET /list_items or /list_items.json
  def index
    @list_items = @list.items
  end

  # GET /list_items/1 or /list_items/1.json
  def show
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new
  end

  # GET /list_items/1/edit
  def edit
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
  end

  # POST /list_items or /list_items.json
  def create
    @list_item = @list.list_items.build(list_item_params)

    respond_to do |format|
      if @list_item.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("todo-items", partial: "lists/todo_item", locals: { item: @list_item }),
            turbo_stream.replace("new_list_item_form", partial: "form", locals: { list: @list, list_item: @list.list_items.build })
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_list_item_form", partial: "form", locals: { list: @list, list_item: @list_item })
        end
      end
    end
  end

  # PATCH/PUT /list_items/1 or /list_items/1.json
  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
      @list_item.list.update_completion_status!
       format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("todo-items", partial: "lists/todo_item", locals: { item: @list_item })
          ]
        end
      format.html { redirect_to @list_item.list, notice: "List Item was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1 or /list_items/1.json
  def destroy
    @list_item.destroy!

    respond_to do |format|
      format.html { redirect_to list_path(@list), status: :see_other, notice: "List item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_list_item
      @list_item = @list.list_items.find(params[:id])
    end

    def list_item_params
      params.expect(list_item: [ :list_id, :name, :position, :completed ])
    end
end

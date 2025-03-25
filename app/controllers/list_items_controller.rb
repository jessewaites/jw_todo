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
  end

  # POST /list_items or /list_items.json
  def create
   @list_item = @list.list_items.build(list_item_params)

    respond_to do |format|
      if @list_item.save
        format.turbo_stream { }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_items/1 or /list_items/1.json
  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.html { redirect_to @list_item, notice: "List item was successfully updated." }
        format.json { render :show, status: :ok, location: @list_item }
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
      format.html { redirect_to list_items_path, status: :see_other, notice: "List item was successfully destroyed." }
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
      params.expect(list_item: [ :list_id, :name, :position, :status ])
    end
end

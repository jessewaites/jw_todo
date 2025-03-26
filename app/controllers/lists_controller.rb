class ListsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_list, only: %i[ show edit update destroy ]

  # GET /lists or /lists.json
  def index
    # @lists = List.all.where(public: true)
    #
    @completed_filter = params[:completed_filter] || "all"

    @lists = List.order(created_at: :desc).where(public: true)

    @lists = case @completed_filter
    when "completed"
               @lists.where(completed: true)
    when "not_completed"
               @lists.where(completed: false)
    else
               @lists
    end
  end

  # GET /lists/1 or /lists/1.json
  def show
  if @list.public?
    @list_item = @list.list_items.build
  elsif @list.user == current_user
    @list_item = @list.list_items.build
  else
    redirect_to root_path, alert: "You do not have permission to view that list."
    nil
  end
end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy!

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.expect(list: [ :name, :user_id, :public, :status ])
    end
end

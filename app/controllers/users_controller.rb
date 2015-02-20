class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # good api example https://codelation.com/blog/rails-restful-api-just-add-water
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user=User.new
    if @users.count>10
      @selectedusers = User.all.reverse.take(3)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        
        @list_id = "9505ea65c4"
        gb = Gibbon::API.new

        gb.lists.subscribe({
        :id => @list_id,
        :email => {:email => @user.email },
        :merge_vars => {:FNAME => @user.first_name, :LNAME => @user.last_name },
        :double_optin => false
        })
        
        
        flash[:success] = "Awesome. Thanks #{@user.first_name}. Check back soon for updates."
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    end
end

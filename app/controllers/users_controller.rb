class UsersController <ApplicationController
    before_action :set_user, only: [:edit,:update,:show,:destroy]
    before_action :require_same_user, only: [:edit, :update,:destroy]
    before_action :require_admin, only:[:destroy]
    def new
        @user=User.new
    end
    def create
        @user=User.new(set_params)
        if @user.save
            session[:user_id]=@user.id
            flash[:success]="Welcome to the alpha blog #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end
    def edit
    end
    def update
        if @user.update(set_params)
            flash[:success]="User updated"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def show
    end
    def index
        @users=User.paginate(page: params[:page],per_page:5)
    end
    def destroy
        @user.destroy
        flash[:danger]="User destroyed with his/her articles"
        redirect_to articles_path
    end
    private
    def set_params
        params.require(:user).permit(:username,:email,:password)
    end
    def set_user
        @user = User.find(params[:id])
      end
    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:danger]="You can't edit other users"
            redirect_to root_path
    end
  end
  def require_admin
    if logged_in? && !current_user.admin?
        flash[:danger]="You can't do that, you're not admin"
            redirect_to root_path
    end
  end
end 
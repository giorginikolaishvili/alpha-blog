class UsersController <ApplicationController
    def new
        @user=User.new
    end
    def create
        @user=User.new(set_params)
        if @user.save
            flash[:success]="Welcome to the alpha blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def edit
        @user=User.find(params[:id])
    end
    def update
        @user=User.find(params[:id])
        if @user.update(set_params)
            flash[:success]="User updated"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def show
        @user=User.find(params[:id])
    end
    def index
        @users=User.paginate(page: params[:page],per_page:5)
    end
    private
    def set_params
        params.require(:user).permit(:username,:email,:password)
    end
end 
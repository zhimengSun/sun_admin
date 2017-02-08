class Admin::UsersController < SunAdminBaseController
  def destroy
    return back_to_list(true, "不能删除自己！") if current_user.id == @user.id
    back_to_list(@user.destroy)
  end
end

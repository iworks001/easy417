# plugins/cf_list_group/app/controllers/cf_groups_controller.rb
class CfGroupsController < ApplicationController
  layout 'admin'
  before_action :require_admin
  before_action :set_cf_group, only: [:edit, :update, :destroy]

  def index
    @cf_groups = CfGroup.all
    @custom_fields = CustomField.where(field_format: 'list')
  end

  def new
    @cf_group = CfGroup.new
    @custom_fields = CustomField.where(field_format: 'list')
    if params[:custom_field_id].present?
      @custom_field = CustomField.find(params[:custom_field_id])
      @values = @custom_field.possible_values.to_s.split(/\r?\n/)
    else
      @values = []
    end
  end

  def create
    @cf_group = CfGroup.new(cf_group_params)
    if @cf_group.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to cf_groups_path
    else
      @custom_fields = CustomField.where(field_format: 'list')
      render :new
    end
  end

  def edit
    @custom_fields = CustomField.where(field_format: 'list')
    @custom_field = @cf_group.custom_field
    @values = @custom_field.possible_values.to_s.split(/\r?\n/)
  end

  def update
    if @cf_group.update(cf_group_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to cf_groups_path
    else
      @custom_fields = CustomField.where(field_format: 'list')
      @custom_field = @cf_group.custom_field
      @values = @custom_field.possible_values.to_s.split(/\r?\n/)
      render :edit
    end
  end

  def destroy
    @cf_group.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to cf_groups_path
  end

  private

  def set_cf_group
    @cf_group = CfGroup.find(params[:id])
  end

  def cf_group_params
    params.require(:cf_group).permit(:name, :custom_field_id, { group_values: [] })
  end
end


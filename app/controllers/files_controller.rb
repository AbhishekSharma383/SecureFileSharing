class FilesController < ApplicationController
before_action :authenticate_user!
before_action :set_file, only: [:show, :destroy, :generate_share_link, :revoke_share_link]

def index
  @files = current_user.uploaded_files.order(created_at: :desc)
end

def show
  if @file.file.attached?
    send_data @file.file.download, 
              filename: @file.file.filename.to_s,
              content_type: @file.content_type
  else
    redirect_to files_path, alert: 'File not found'
  end
end

def new
  @file = current_user.uploaded_files.build
end

def create
  @file = current_user.uploaded_files.build(file_params)
  if @file.save
    redirect_to files_path, notice: 'File was successfully uploaded.'
  else
    render :new, status: :unprocessable_entity
  end
end

def destroy
  @file.destroy
  redirect_to files_path, notice: 'File was successfully deleted.'
end

def generate_share_link
  if @file.generate_share_token
    redirect_to files_path, notice: 'Share link generated successfully.'
  else
    redirect_to files_path, alert: 'Error generating share link.'
  end
end

def revoke_share_link
  if @file.revoke_share_token
    redirect_to files_path, notice: 'Share link revoked successfully.'
  else
    redirect_to files_path, alert: 'Error revoking share link.'
  end
end

private

def set_file
  @file = current_user.uploaded_files.find(params[:id])
rescue ActiveRecord::RecordNotFound
  redirect_to files_path, alert: 'File not found or access denied'
end

def file_params
  params.require(:uploaded_file).permit(:title, :description, :file)
end
end
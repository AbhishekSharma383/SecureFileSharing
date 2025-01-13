class SharedFilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
  def show
    @file = UploadedFile.find_by!(share_token: params[:token])
    
    respond_to do |format|
      format.html
      format.json { render json: { url: rails_blob_url(@file.file) } }
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404.html', status: :not_found
  end
end
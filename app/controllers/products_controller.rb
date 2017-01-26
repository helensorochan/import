class ProductsController < ApplicationController
  inherit_resources

  def import
    ImportWorker.perform_async(params[:file].tempfile.path)
    redirect_to :back
  end
end
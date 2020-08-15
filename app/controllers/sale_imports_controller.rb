class SaleImportsController < ApplicationController
  def new
    @form_object = SalesImportFormObject.new
  end

  def create
    @form_object = SalesImportFormObject.new(permitted_params)

    respond_to do |format|
      if @form_object.valid?
        @sale_import = SalesImporter::Importer.call(@form_object.file.read)
        format.html { redirect_to @sale_import }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @sale_import = SaleImport.find(params[:id])
  end

  private

  def permitted_params
    params.fetch(:sales_import_form_object, {}).permit(:file)
  end

end

module ResponseService


  def responseApi(status,message,data={},state=:ok)

    return render json:{status: status, message: message, data:data}, status: state
  end
end
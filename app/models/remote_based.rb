module RemoteBased

  def fetch(id)
    remote = "remote_#{self.name}".classify.constantize.find(id)
    remote.add
  end

end

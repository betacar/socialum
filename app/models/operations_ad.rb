class OperationsAd
  @authenticated = false
  
  def initialize(args = nil)
    self.connect_ldap()
  end
  
  def connect_ldap()
    @ldap = Net::LDAP.new
    @ldap.host = "128.1.33.44"
    @ldap.port = 389
    @ldap.auth "s_cuboinfo@bauxilum.com.ve", "123456"
    
    if @ldap.bind
      @authenticated = true
    end
  end
  
  def Atributo(atributo, username)
    if @authenticated then
      filter = Net::LDAP::Filter.eq("sAMAccountName", username)
      treebase = "dc=bauxilum,dc=com,dc=ve"
      
      @ldap.search(:base => treebase, :filter => filter) do |entry|
        return entry[atributo]
      end
    end
  end
end

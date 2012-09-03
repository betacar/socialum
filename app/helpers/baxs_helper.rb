module BaxsHelper
  def formato_bax bax_id
    bax_id.gsub(/-/, '/')
  end
end

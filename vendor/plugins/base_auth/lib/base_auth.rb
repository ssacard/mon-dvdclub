# BaseAuth

module Authorization

  DEFAULT_PERMISSION_DENIED_MESSAGE = 'You have no permissions to access this page.'

  def self.included( base )
    base.extend( ClassMethods )
    base.send( :include, InstanceMethods )
  end

  class PermissionDenied < Exception
    attr :message
    def initialize( message = nil )
      @message = message || DEFAULT_PERMISSION_DENIED_MESSAGE
    end
    def clean_message
      @message
    end
    def to_s
      @message
    end
  end
  
  module InstanceMethods
  
    def eval_authorization_conditions( conditions )
      exec = conditions[:exec]
      if exec
        case exec.class.name
          when 'Symbol':
            send( exec )
          when 'String':
            eval( exec )
          when 'Proc':
            exec.call
          else
            raise ArgumentError( ":exec doesn't accept values of class #{exec.class.name}" )
        end
      elsif conditions[:user]
        if conditions[:user].is_a?( String )
          return current_user.instance_eval conditions[:user]
        end
        o = conditions[:object] || controller_name.singularize.to_sym
        object = o.is_a?( Symbol ) ? eval("@#{o}") : o
        
        methods = conditions[:user]
        methods = [ methods ] if not methods.is_a?( Array )
        
        for method in methods
          if current_user.respond_to?( method ) and
             current_user.method( method ).arity == 0
            return true if current_user.send( method )
          else
            return true if current_user.send( method, object )
          end
        end
        return false
      end
    end
    
    def allow?( conditions )
      eval_authorization_conditions( conditions )
    end
    
    def deny?( conditions )
      !eval_authorization_conditions( conditions )
    end
    
    def allow!( conditions )
      invoke_permission_denied_action( conditions ) unless allow?( conditions )
    end
    
    def deny!( conditions )
      invoke_permission_denied_action( conditions ) unless deny?( conditions )
    end
    
    def allow( conditions )
      if allow?( conditions )
        yield
      end
    end

    def deny( conditions )
      if deny?( conditions )
        yield
      end
    end

    def invoke_permission_denied_action( config )
      if config[:redirect_to]
        redirect_to config[:redirect_to]
      elsif config[:method]
        send( config[:method] )
      else
        raise Authorization::PermissionDenied.new( config[:message] )
      end
      false
    end
    
  end

  module ClassMethods
  
    def authorization_filter( action, attrs )
      config = { }
      config.update( attrs.pop ) if attrs.last.is_a?( Hash )
      
      opts = {}
      opts[:only] = config[:only]
      opts[:only] ||= attrs unless attrs.blank?
      opts[:except] = config[:except]
      
      if config[:if]
        
      end
      
      before_filter opts do |controller|
        if action == :allow
          controller.allow! config
        else
          controller.deny! config
        end
      end
    end
  
    def allow( *attrs )
      authorization_filter :allow, attrs
    end

    def deny( *attrs )
      authorization_filter :deny, attrs
    end
  end

end

ActionController::Base.send( :include, Authorization )
ActionController::Base.send( :helper_method, [ :allow, :deny ] )

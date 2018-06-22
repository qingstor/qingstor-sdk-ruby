#  +-------------------------------------------------------------------------
#  | Copyright (C) 2016 Yunify, Inc.
#  +-------------------------------------------------------------------------
#  | Licensed under the Apache License, Version 2.0 (the "License");
#  | you may not use this work except in compliance with the License.
#  | You may obtain a copy of the License in the LICENSE file, or at:
#  |
#  | http://www.apache.org/licenses/LICENSE-2.0
#  |
#  | Unless required by applicable law or agreed to in writing, software
#  | distributed under the License is distributed on an "AS IS" BASIS,
#  | WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  | See the License for the specific language governing permissions and
#  | limitations under the License.
#  +-------------------------------------------------------------------------

require 'active_support/core_ext/hash/keys'

module QingStor
  module SDK
    
    
    

    class Metadata
    attr_accessor :config, :properties

      
        def initialize(config, properties)
          self.config     = config
          self.properties = properties.deep_symbolize_keys
        end
      

      
        
  
  

  # delete_metadata: Delete a Metadata.
  # Documentation URL: https://docs.qingcloud.com/qingstor/api/common/metadata
  def delete_metadata()
  request = delete_metadata_request 
    request.send
  end

  
  
  
  

  def delete_metadata_request()
  input   = {
        config:         config,
          properties:     properties,
        api_name:       'DELETE Metadata',
        request_method: 'DELETE',
        request_uri:    '/<bucket-name>?metadata',
        request_params: {
          },
        request_headers: {
          },
        request_elements: {
          },
          request_body: nil,
        
        status_code: {
          204,
            },
      }

      delete_metadata_input_validate input
      Request.new input
    end

        
  
  
  

  

  private

  def delete_metadata_input_validate(input)
    input.deep_stringify_keys!
    
  
  
  

  


    
      
      
  
  
  

  

    

    
    
  
  
  

  

  end

  public

      
        
  
  

  # get_metadata: GET Metadata.
  # Documentation URL: https://docs.qingcloud.com/qingstor/api/common/metadata
  def get_metadata()
  request = get_metadata_request 
    request.send
  end

  
  
  
  

  def get_metadata_request()
  input   = {
        config:         config,
          properties:     properties,
        api_name:       'GET Metadata',
        request_method: 'GET',
        request_uri:    '/<bucket-name>?metadata',
        request_params: {
          },
        request_headers: {
          },
        request_elements: {
          },
          request_body: nil,
        
        status_code: {
          200,
            },
      }

      get_metadata_input_validate input
      Request.new input
    end

        
  
  
  

  

  private

  def get_metadata_input_validate(input)
    input.deep_stringify_keys!
    
  
  
  

  


    
      
      
  
  
  

  

    

    
    
  
  
  

  

  end

  public

      
        
  
  

  # put_metadata: Create a new Metadata.
  # Documentation URL: https://docs.qingcloud.com/qingstor/api/common/metadata
  def put_metadata()
  request = put_metadata_request 
    request.send
  end

  
  
  
  

  def put_metadata_request()
  input   = {
        config:         config,
          properties:     properties,
        api_name:       'PUT Metadata',
        request_method: 'PUT',
        request_uri:    '/<bucket-name>?metadata',
        request_params: {
          },
        request_headers: {
          },
        request_elements: {
          },
          request_body: nil,
        
        status_code: {
          201,
            },
      }

      put_metadata_input_validate input
      Request.new input
    end

        
  
  
  

  

  private

  def put_metadata_input_validate(input)
    input.deep_stringify_keys!
    
  
  
  

  


    
      
      
  
  
  

  

    

    
    
  
  
  

  

  end

  public

      
    end
  end
end














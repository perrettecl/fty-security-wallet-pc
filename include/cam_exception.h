/*  =========================================================================
    cam_exception - Credential asset mapping exceptions

    Copyright (C) 2019 Eaton

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
    =========================================================================
*/

#ifndef CAM_EXCEPTION_H_INCLUDED
#define CAM_EXCEPTION_H_INCLUDED


#include <exception>
#include <string>

#include <cxxtools/serializationinfo.h>


namespace cam
{
    enum ErrorCode : uint8_t
    {
        GENERIC = 0,
        UNSUPPORTED_COMMAND,
        PROTOCOL_ERROR,
        BAD_COMMAND_ARGUMENT,
        MAPPING_DO_NOT_EXIST,
        MAPPING_ALREADY_EXIST,
        MAPPING_INVALID,
    };

    class CamException : public std::exception
    {
    public:
        explicit CamException(const std::string & whatArg, ErrorCode code = ErrorCode::GENERIC);
        explicit CamException(ErrorCode code = ErrorCode::GENERIC);
        
        virtual ~CamException(){}
        
        const char* what() const noexcept override;

        inline ErrorCode getErrorCode() const { return m_code; }

        //return an error payload from an exception
        std::string toJson() const;

        friend void operator<<= (cxxtools::SerializationInfo& si, const CamException & exception);

        //throw the good exception base on the error payload
        static void throwCamException(const std::string & data);
        
    protected:
        virtual void fillSerializationInfo(cxxtools::SerializationInfo& si) const;
        
    private:
        ErrorCode m_code;

    protected:
        std::string m_whatArg;
    };

    void operator<<= (cxxtools::SerializationInfo& si, const CamException & exception);

// Command is not supported
    class CamUnsupportedCommandException : public CamException
    {
    private:
        std::string m_command;

        void fillSerializationInfo(cxxtools::SerializationInfo& si) const override
        {
            si.addMember("command") <<= m_command;
        }

    public:
        explicit CamUnsupportedCommandException(const std::string & command) :
            CamException(ErrorCode::UNSUPPORTED_COMMAND),
            m_command(command)
        {
            m_whatArg = "Unsupported command: '"+m_command+"'";
        }

        explicit CamUnsupportedCommandException(const cxxtools::SerializationInfo& extraData, const std::string & whatArg) :
            CamException(whatArg, ErrorCode::UNSUPPORTED_COMMAND)
        {
            extraData.getMember("command") >>= m_command;
        }

        inline std::string getCommand() const { return m_command; }
    };

// Wrong message format => the message do not comply to the protocol
    class CamProtocolErrorException : public CamException
    {
    public:
        explicit CamProtocolErrorException(const std::string & whatArg = "Protocol error") :
            CamException(whatArg, ErrorCode::PROTOCOL_ERROR)
        {}
    };


// Arguments for the command are not good
    class CamBadCommandArgumentException : public CamException
    {
    private:
        std::string m_argument;

        void fillSerializationInfo(cxxtools::SerializationInfo& si) const override
        {
            si.addMember("argument") <<= m_argument;
        }

    public:
        explicit CamBadCommandArgumentException(const std::string & argument, const std::string & reason = "") :
            CamException(ErrorCode::BAD_COMMAND_ARGUMENT),
            m_argument(argument)
        {
            m_whatArg = "Command argument error: '"+m_argument+"' " + reason;
        }

        explicit CamBadCommandArgumentException(const cxxtools::SerializationInfo& extraData, const std::string & whatArg) :
            CamException(whatArg, ErrorCode::BAD_COMMAND_ARGUMENT)
        {
            extraData.getMember("argument") >>= m_argument;
        }

        inline std::string getArgument() const { return m_argument; }
    };
    
// Mapping do not exist
    class CamMappingDoNotExistException : public CamException
    {
    private:
        std::string m_asset, m_usage;

        void fillSerializationInfo(cxxtools::SerializationInfo& si) const override
        {
            si.addMember("asset") <<= m_asset;
            si.addMember("usage") <<= m_usage;
        }
    public:
        explicit CamMappingDoNotExistException(const std::string & asset, const std::string & usage) :
            CamException(ErrorCode::MAPPING_DO_NOT_EXIST),
            m_asset(asset),
            m_usage(usage)
        {
            m_whatArg = "Mapping for asset '"+m_asset+"' and usage '" + m_usage + "' do not exist";
        }

        explicit CamMappingDoNotExistException(const cxxtools::SerializationInfo& extraData, const std::string & whatArg) :
            CamException(whatArg, ErrorCode::MAPPING_DO_NOT_EXIST)
        {
            extraData.getMember("asset") >>= m_asset;
            extraData.getMember("usage") >>= m_usage;
        }

        inline std::string getAssetId() const { return m_asset; }
        inline std::string getUsageId() const { return m_usage; }
    };

// Mapping already exist
    class CamMappingAlreadyExistException : public CamException
    {
    private:
        std::string m_asset, m_usage;

        void fillSerializationInfo(cxxtools::SerializationInfo& si) const override
        {
            si.addMember("asset") <<= m_asset;
            si.addMember("usage") <<= m_usage;
        }
        
    public:
        explicit CamMappingAlreadyExistException(const std::string & asset, const std::string & usage) :
            CamException(ErrorCode::MAPPING_ALREADY_EXIST),
            m_asset(asset),
            m_usage(usage)
        {
             m_whatArg = "Mapping for asset '"+m_asset+"' and usage '" + m_usage + "' already exist";
        }

        explicit CamMappingAlreadyExistException(const cxxtools::SerializationInfo& extraData, const std::string & whatArg) :
            CamException(whatArg, ErrorCode::MAPPING_ALREADY_EXIST)
        {
            extraData.getMember("asset") >>= m_asset;
            extraData.getMember("usage") >>= m_usage;
        }
        
        inline std::string getAssetId() const { return m_asset; }
        inline std::string getUsageId() const { return m_usage; }
    };

// Mapping invalid
    class CamMappingInvalidException : public CamException
    {
    public:
        explicit CamMappingInvalidException(const std::string & whatArg) :
            CamException(whatArg, ErrorCode::MAPPING_INVALID)
        {}
    };

} // namepsace cam

#endif
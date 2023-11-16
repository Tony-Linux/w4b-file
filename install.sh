#!/usr/bin/env ruby

############################################################################
#                      © 2023 Tony-Linux. All Rights Reserved.             #
#          For inquiries regarding this project, kindly reach out to:      #
#                    Email: mrhunter5@proton.me                            #
#                                                                          #
#    This content is protected by copyright law and may not be replicated  #
#     or altered without the explicit written consent of the copyright     #
#                               holder.                                    #
############################################################################

def usage
  puts <<~USAGE
    secret-web :  is a GitHub tool that scans sites for files. It finds file types and shows hidden files. Examples: PDFs, images, videos, or all site files.
    LINK : https://github.com/Tony-Linux/secret-web
    Usage : secret-web <website_url> [--check <file_type>|--check all]

    Options:
      <website_url>   The URL of the website to scan for files.
      --check <file_type>   Specify the type of files to check (pdf, image, video, php, zip, doc, hidden).
      ruby secret-web <website_url>      Check and display all files on the website.

    Examples:
      ruby secret-web example-url.com                   # Check various types of files on the website.
      ruby secret-web example-url.com --check pdf       # Check all PDF files on the website.
      ruby secret-web example-url.com --check image     # Check all image files on the website.
      ruby secret-web example-url.com --check hidden    # Check hidden files on the website.
      ruby secret-web example-url.com --check all       # Check and display all files on the website.
      ruby secret-web example-url.com --check zip       # Check all ZIP files on the website.
      ruby secret-web example-url.com --check document  # Check all document files on the website.
      ruby secret-web example-url.com --check videos    # Check Video files on the website.
  USAGE
end

def check_root_access
  if Process.uid != 0
    puts "Root access is necessary for using this tool."
    exit 1
  end
end

def setup_secret_web
  bin_path = ENV['PATH'].split(':').grep(/\/bin$/).first
  target_path = "#{bin_path}/secret-web"
  
  if File.exist?('.tool/secret-web')
    File.rename('.tool/secret-web', target_path)
    File.chmod(0755, target_path)
    
    exec('secret-web', *ARGV) if system('secret-web', *ARGV)
  else
    puts "Error: The source file '.tool/secret-web' does not exist."
  end
end

def main
  usage unless system('bash', '-c', 'command -v bash &>/dev/null')
  check_root_access if system('bash', '-c', 'command -v sudo &>/dev/null')

  if system('bash', '-c', 'command -v secret-web &>/dev/null')
    exec('secret-web', *ARGV)
  else
    setup_secret_web
  end
end

main
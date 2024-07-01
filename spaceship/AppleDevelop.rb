#!/usr/bin/ruby
require 'Spaceship'

$appid="linshen1342@icloud.com"
$password="AAssdd123123"
# $appid="yyv2nef2bp@hotmail.com"
# $password="Dd112211"

$uuid1 = "317fec20174d428b0dcb75a07fe4cf57e92591f6"
$uuid2 = "00008110-0006784E1E07801E"

Spaceship::Portal.login($appid, $password)

# 获取所有 Device List
def device_list()
    devides = Spaceship::Portal.device.all_iphones

    puts "Device List count : #{devides.count}"
    puts "Device List detail:"
    # puts devides
    devides.each do |device|
        # puts device
        puts device.udid
    end
end

# 解禁设备
def device_enable(udid="")
    device = Spaceship::Portal.device.find_by_udid(udid,include_disabled:true)
    puts device

    # puts "当前要解除的设备  udid=#{device.udid} model=#{device.model}"
    puts "Device enable:" # 解禁设备
    device.enable!
    puts "device=#{device}"
end

# 禁用设备
def device_disable(udid="")
    device = Spaceship::Portal.device.find_by_udid(udid,include_disabled:true)
    puts device

    puts "Device disable:" # 禁用设备
    device.disable!
    puts device
end

# 添加设备
def device_add_udid(name="",udid="")
        device = Spaceship::Portal.device.create!(name: name, udid: udid)
        puts "add device: #{device.name} #{device.udid} #{device.model}"
end

# 创建证书
def certificate_create()
    # Create a new certificate signing request
    csr, pkey = Spaceship::Portal.certificate.create_certificate_signing_request
    File.write("/Users/lzd/Repository/ruby_study/custom.key", pkey)
    File.write("/Users/lzd/Repository/ruby_study/custom.csr", csr)
    # Use the signing request to create a new distribution certificate
    # Spaceship::Portal.certificate.production.create!(csr: csr)

    # Use the signing request to create a new development certificate
    # Spaceship::Portal.certificate.development.create!(csr: csr)
end

# 获取证书
def certificate_get()
    # Fetch all available certificates (includes signing and push profiles)
    certificates = Spaceship::Portal.certificate.all

    # Production identities
    # certificates = Spaceship::Portal.certificate.production.all

    # Development identities
    # certificates = Spaceship::Portal.certificate.development.all

    certificates.each do |item|
        puts item
        puts "------------------------------------"
        puts item.id
        puts item.name
        puts item.status
        puts item.expires
        puts "------------------ one was done ------------------"
    end

    # cert_id = "NR7U94GVJU"
    # certificate = Spaceship::Portal.certificate.find(cert_id)
    # puts certificate
    # puts "------------------ certificate by id ------------------"

    # Download a certificate
    # cert_content = prod_certs.first.download
end

# 创建描述文件 provision
def provision_create(name="",bundle_id="",cert_id="")
    devCer = Spaceship::Portal.certificate.find(cert_id)
    puts "devCer = #{devCer}"
    devides = Spaceship::Portal.device.all_iphones
    # puts devides
    Spaceship::Portal.provisioning_profile.Development.create!(name:name, bundle_id:bundle_id, certificate:devCer, devices:devides, mac:false)
end

def provision_adhoc_create(name="",bundle_id="",cert_id="")
    devCer = Spaceship::Portal.certificate.find(cert_id)
    puts "devCer = #{devCer}"
    devides = Spaceship::Portal.device.all_iphones
    # puts devides
    Spaceship::Portal.provisioning_profile.ad_hoc.create!(name:name, bundle_id:bundle_id, certificate:devCer, devices:devides, mac:false)
end

# 获取描述文件
def provision_get(path="",name="")
    # Get all available provisioning profiles
    # profiles = Spaceship::Portal.provisioning_profile.all

    # Get all App Store and Ad Hoc profiles
    # profiles_appstore_adhoc = Spaceship::Portal.provisioning_profile.app_store.all
    # profiles = Spaceship::Portal.provisioning_profile.ad_hoc.all

    # Get all Development profiles
    # profiles = Spaceship::Portal.provisioning_profile.development.all

    # Get all Ad Hoc profiles by bundle id
    profiles = Spaceship::Portal.provisioning_profile.ad_hoc.find_by_bundle_id(bundle_id: "cn.jobs8.objectivec")
    # Get all Development profiles by bundle id
    # profiles = Spaceship::Portal.provisioning_profile.Development.find_by_bundle_id(bundle_id: "cn.jobs8.objectivec")

    profiles.each do |item|
        puts item
        name = item.name
        File.write("/Users/lzd/Repository/ruby_study/#{name}.mobileprovision", item.download)
        puts "------------------ next ------------------"
    end
end

# device_list
# device_add_udid "iPhone","d0a655c853ddf49dd760ad53d8f94b8fa5f4c618"
# device_enable $uuid1
# device_disable $uuid1
certificate_create
# certificate_get
# provision_create "autotest","*","BGPTVMH48W"
# provision_adhoc_create "autotest10","*","NR7U94GVJU"
# provision_get

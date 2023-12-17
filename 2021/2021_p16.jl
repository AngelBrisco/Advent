#s = open("pt.txt") do file
#    readlines(file)
#end
bits_dict = Dict('0' => "0000",
'1' => "0001",
'2' => "0010",
'3' => "0011",
'4' => "0100",
'5' => "0101",
'6' => "0110",
'7' => "0111",
'8' => "1000",
'9' => "1001",
'A' => "1010",
'B' => "1011",
'C' => "1100",
'D' => "1101",
'E' => "1110",
'F' => "1111")

inp = "005410C99A9802DA00B43887138F72F4F652CC0159FE05E802B3A572DBBE5AA5F56F6B6A4600FCCAACEA9CE0E1002013A55389B064C0269813952F983595234002DA394615002A47E06C0125CF7B74FE00E6FC470D4C0129260B005E73FCDFC3A5B77BF2FB4E0009C27ECEF293824CC76902B3004F8017A999EC22770412BE2A1004E3DCDFA146D00020670B9C0129A8D79BB7E88926BA401BAD004892BBDEF20D253BE70C53CA5399AB648EBBAAF0BD402B95349201938264C7699C5A0592AF8001E3C09972A949AD4AE2CB3230AC37FC919801F2A7A402978002150E60BC6700043A23C618E20008644782F10C80262F005679A679BE733C3F3005BC01496F60865B39AF8A2478A04017DCBEAB32FA0055E6286D31430300AE7C7E79AE55324CA679F9002239992BC689A8D6FE084012AE73BDFE39EBF186738B33BD9FA91B14CB7785EC01CE4DCE1AE2DCFD7D23098A98411973E30052C012978F7DD089689ACD4A7A80CCEFEB9EC56880485951DB00400010D8A30CA1500021B0D625450700227A30A774B2600ACD56F981E580272AA3319ACC04C015C00AFA4616C63D4DFF289319A9DC401008650927B2232F70784AE0124D65A25FD3A34CC61A6449246986E300425AF873A00CD4401C8A90D60E8803D08A0DC673005E692B000DA85B268E4021D4E41C6802E49AB57D1ED1166AD5F47B4433005F401496867C2B3E7112C0050C20043A17C208B240087425871180C01985D07A22980273247801988803B08A2DC191006A2141289640133E80212C3D2C3F377B09900A53E00900021109623425100723DC6884D3B7CFE1D2C6036D180D053002880BC530025C00F700308096110021C00C001E44C00F001955805A62013D0400B400ED500307400949C00F92972B6BC3F47A96D21C5730047003770004323E44F8B80008441C8F51366F38F240"

function str2bin(str,dict)
    output = ""
    for i in str
        output *= dict[i]
    end
    return output
end

function packet_parser(pckt)
    pckt_v = parse(Int32, pckt[1:3],base=2)
    pckt_id = parse(Int32, pckt[4:6],base=2)
    pckt_data = pckt[7:end]
    return pckt_v, pckt_id, pckt_data
end

function pckt_d_proc(pckt_data)
    i = '1'
    out = ""
    while i == '1'
        i = pckt_data[1]
        out *= pckt_data[2:5]
        pckt_data = pckt_data[6:end]
    end
    return parse(Int32, out, base=2), pckt_data
end

function bin_reader(pckt)
    if length(unique(pckt)) == 1
        return
    end

    pckt_v, pckt_id, pckt_data = packet_parser(pckt)

    if pckt_id == 4
        return pckt_v, pckt_id, pckt_d_proc(pckt_data)...
    end

    if pckt_data[1] == '0'
        sp_l = parse(Int32, pckt_data[2:16], base=2)
        pckt_datap = pckt_data[17:end]
        semi_out = []
        while true
            pckt_vi, pckt_idi, out, pckt_datap = bin_reader(pckt_datap)
            push!(semi_out, [pckt_vi, pckt_idi, out])
            if length(unique(pckt_datap)) == 1
                break
            end
        end
        return pckt_v, pckt_id, semi_out, pckt_datap
    end

    if pckt_data[1] == '1'
        n_subp = parse(Int32, pckt_data[2:12], base=2)
        pckt_datap = pckt_data[13:end]
        semi_out = []
        for i in 1:n_subp
            pckt_vi, pckt_idi, out, pckt_datap = bin_reader(pckt_datap)
            push!(semi_out, [pckt_vi, pckt_idi, out])
            if length(unique(pckt_datap)) == 1
                break
            end
        end
        return pckt_v, pckt_id, semi_out, pckt_datap
    end

end

pckt = str2bin(inp,bits_dict)


function sum_versions(arr,t=0)
    if typeof(arr[1])==Int32
        t+=arr[1]
        (typeof(arr[3])==Int32)&&return t
        return sum_versions(arr[3],t)
    end
    for i in 1:length(arr)
        t+= sum_versions(arr[i])
    end
    return t
end

println((bin_reader(pckt)))

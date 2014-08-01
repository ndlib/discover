class HoldData
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def volumes
    @volumes ||= [].tap do |array|
      get(:volumes).each do |volume_data|
        array.push build_volume(volume_data)
      end
    end
  end

  def build_volume(volume_data)
    HoldVolume.new(volume_data)
  end

  def items_hash
    @items_hash ||= {}.tap do |hash|
      get(:items_by_enumeration).each do |items_data|
        hash[items_data["enumeration"]] = build_items(items_data["items"])
      end
    end
  end

  def items(volume_id)
    items_hash[volume_id.to_s]
  end

  def build_items(items_array)
    items_array.collect{ |item_data| HoldItem.new(item_data) }
  end

  def get(key)
    data[key.to_s]
  end
  private :get

  def self.test
    new(tmp_data)
  end

  def self.tmp_data
    {
      "volumes" => [
        {
          "description" => "v.1",
          "enumeration" => "1",
          "sort_order" => "1"
        },
        {
          "description" => "v.2",
          "enumeration" => "2",
          "sort_order" => "2"
        },
        {
          "description" => "v.3",
          "enumeration" => "3",
          "sort_order" => "3"
        },
        {
          "description" => "v.4",
          "enumeration" => "4",
          "sort_order" => "4"
        },
        {
          "description" => "v.5",
          "enumeration" => "5",
          "sort_order" => "5"
        },
        {
          "description" => "v.6",
          "enumeration" => "6",
          "sort_order" => "6"
        },
        {
          "description" => "v.7",
          "enumeration" => "7",
          "sort_order" => "7"
        },
        {
          "description" => "v.8",
          "enumeration" => "8",
          "sort_order" => "8"
        },
        {
          "description" => "v.9",
          "enumeration" => "9",
          "sort_order" => "9"
        }
      ],
      "items_by_enumeration" => [
        {
          "enumeration" => "1",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.1",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000010",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "2",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.2",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000020",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "3",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.3",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000030",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "4",
          "items" => [
            {
              "institution_code" => "HESB",
              "pickup_locations" => [
                {
                  "code" => "NDCAM",
                  "content" => "Notre Dame Dept. Delivery"
                },
                {
                  "code" => "HESB",
                  "content" => "Hesburgh Library"
                },
                {
                  "code" => "ARCHT",
                  "content" => "Architecture [117 Bond]"
                },
                {
                  "code" => "MATH",
                  "content" => "Mathematics [001 Hayes-Healy]"
                },
                {
                  "code" => "CHEMP",
                  "content" => "Chem/Physics [231 Nieuwland]"
                },
                {
                  "code" => "ENGIN",
                  "content" => "Engineering [149 Fitzpatrick]"
                },
                {
                  "code" => "BIC",
                  "content" => "Business Lib. [L001 Mendoza]"
                },
                {
                  "code" => "BCI_N",
                  "content" => "Bethel (allow extra time)"
                },
                {
                  "code" => "HCC_N",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "SMC_N",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v. 4",
              "bib_id" => "001526576",
              "item_id" => "MLC200046090$$$NDU01001526576$$$NDU50001526576000010",
              "status_message" => "Requested",
              "location" => "B 72 .C62 1993"
            },
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.4",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000040",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "5",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.5",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000050",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "6",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.6",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000060",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "7",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.7",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000070",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "8",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.8",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000080",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        },
        {
          "enumeration" => "9",
          "items" => [
            {
              "institution_code" => "BCI",
              "pickup_locations" => [
                {
                  "code" => "BCI",
                  "content" => "Bethel College"
                },
                {
                  "code" => "HCC_B",
                  "content" => "Holy Cross (allow extra time)"
                },
                {
                  "code" => "NDU_B",
                  "content" => "Hesburgh (allow extra time)"
                },
                {
                  "code" => "SMC_B",
                  "content" => "Saint Mary's(allow extra time)"
                }
              ],
              "description" => "v.9",
              "bib_id" => "000136357",
              "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000090",
              "status_message" => "",
              "location" => "B 72 .C62 1993"
            }
          ]
        }
      ]
    }
  end
end

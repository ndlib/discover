require 'spec_helper'

describe HoldData do
  subject { described_class.new(data) }

  describe 'multi volume' do
    let(:data) { hold_data() }

    describe '#volumes' do
      it 'is a collection of volumes' do
        expect(subject.volumes).to be_a_kind_of(Array)
        expect(subject.volumes.first).to be_a_kind_of(HoldVolume)
        expect(subject.volumes.count).to eq(9)
        expect(subject.volumes.first.items).to be_a_kind_of(Array)
        expect(subject.volumes.first.items.first).to be_a_kind_of(HoldItem)
      end
    end

    describe '#items_hash' do
      it 'is a collection of items by enumeration' do
        expect(subject.items_hash).to be_a_kind_of(Hash)
        expect(subject.items_hash.count).to eq(9)
      end
    end

    describe '#items' do
      it 'returns an array of items for an enumeration' do
        expect(subject.items('4')).to be_a_kind_of(Array)
        expect(subject.items('4').first).to be_a_kind_of(HoldItem)
        expect(subject.items('4').count).to eq(2)
      end
    end

    describe '#single_volume?' do
      it 'is false' do
        expect(subject.single_volume?).to be_false
      end
    end
  end

  describe 'single volume' do
    let(:data) { single_volume_data() }

    describe '#single_volume?' do
      it 'is true' do
        expect(subject.single_volume?).to be_true
      end
    end
  end

  describe 'combination volume' do
    let(:data) { combination_volume_data }

    describe '#volumes' do
      it 'is a collection of volumes' do
        expect(subject.volumes).to be_a_kind_of(Array)
        expect(subject.volumes.first).to be_a_kind_of(HoldVolume)
        expect(subject.volumes.count).to eq(1)
        expect(subject.volumes.first.items).to be_a_kind_of(Array)
        expect(subject.volumes.first.items.first).to be_a_kind_of(HoldItem)
      end
    end
  end

  def single_volume_data
    {
      "volumes" =>  [
        {
          "description" =>  "single_volume",
          "enumeration" =>  "1",
          "sort_order" =>  "1"
        }
      ],
      "items_by_enumeration" =>  [
        {
          "enumeration" =>  "1",
          "items" =>  [
            {
              "institution_code" =>  "HCC",
              "pickup_locations" =>  [
                {
                  "code" =>  "HCC",
                  "content" =>  "Holy Cross College"
                },
                {
                  "code" =>  "BCI_H",
                  "content" =>  "Bethel (allow extra time)"
                },
                {
                  "code" =>  "NDU_H",
                  "content" =>  "Hesburgh (allow extra time)"
                },
                {
                  "code" =>  "SMC_H",
                  "content" =>  "Saint Mary's(allow extra time)"
                }
              ],
              "description" =>  nil,
              "bib_id" =>  "000022674",
              "item_id" =>  "MLC200046090$$$HCC01000021761$$$HCC50000022674000010",
              "status_message" =>  "",
              "location" =>  "813.54 S26 2001"
            }
          ]
        }
      ]
    }
  end

  def combination_volume_data
    {
      "volumes" =>  [
        {
          "description" => "v.9/10 (June 1975/May 1976)",
          "enumeration" => "9/10",
          "sort_order" => "9/10"
        }
      ],
      "items_by_enumeration" => [
        {
          "enumeration" => "9/10",
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
              "description" => "v.9/10 (June 1975/May 1976)",
              "bib_id" => "000038864",
              "item_id" => "PRIMO$$$BCI01000038864$$$BCI50000038864000120",
              "status_message" => "",
              "location" => "Shelved by title"
            }
          ]
        }
      ]
    }
  end

  def hold_data
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

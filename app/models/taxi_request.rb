class TaxiRequest < ApplicationRecord
  validates_presence_of :passenger_id
  validates_presence_of :address
  validates_presence_of :requested_at

  # todo] driver_id, assigned_at 는 이 클래스에 여전히 남아 있어야 할 것 같은데,
  # todo] nullable attribute 이기 때문에 validates_presence_of 로 하면 테스트가 실패함. 찾아보기
end

Spree::Payment.class_eval do
  self.state_machine.before_transition to: :completed, do: :avalara_finalize
  self.state_machine.after_transition to: :void, do: :cancel_avalara

  def avalara_eligible?
    Spree::Config.avatax_iseligible
  end

  def cancel_avalara
    order.avalara_transaction.cancel_order unless order.avalara_transaction.nil?
  end

  def avalara_finalize
    return unless avalara_eligible?

    if self.amount != order.total
      self.update_attributes(amount: order.total)
    end

    order.avalara_capture_finalize
  end
end

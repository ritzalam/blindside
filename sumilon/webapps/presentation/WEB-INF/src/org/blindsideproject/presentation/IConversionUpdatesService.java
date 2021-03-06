package org.blindsideproject.presentation;

import javax.jms.Destination;
import org.springframework.jms.core.JmsTemplate;
import org.apache.activemq.command.ActiveMQQueue;

public interface IConversionUpdatesService {
	public void start();
	public void stop();
	
	public void setDestination(ActiveMQQueue destination);
	public void setJmsTemplate(JmsTemplate jmsTemplate);
}